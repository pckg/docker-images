<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

$file = 'Dockerfile-' . $argv[1];
$dir = __DIR__ . '/';
$apk = ($argv[2] ?? false) === 'alpine';

if ($file === 'Dockerfile-') {
    $file = 'Dockerfile';
}

$content = file_get_contents($dir . $file);
$lines = explode("\n", $content);

function replaceAlpine($s)
{
    return $s;
}

function optimizeFlow($data)
{
    /**
     * This should be done in-above?
     */
    $sort = true;
    if ($sort) {
        $sorted = [
            // add repositories
            0 => [],
            // update
            1 => [],
            // install
            2 => [],
            // more?
            3 => [],
        ];
        foreach ($data as $line) {
            $key = 3;
            if (strpos($line, 'add-apt-repository') !== false) {
                $key = 0;
            } else if (strpos($line, 'sudo -E bash -') !== false) {
                $key = 0;
            } else if (strpos($line, ' apt-key add ') !== false) {
                $key = 0;
            } else if (strpos($line, ' stable main') !== false) {
                $key = 0;
            } else if (strpos($line, '-y update')) {
                $key = 1;
            } else if (strpos($line, 'apt-get install') !== false) {
                $key = 2;
            }

            $sorted[$key][] = $line;
        }
        $newData = [];
        foreach ($sorted as $i => $lines) {
            foreach ($lines as $line) {
                $newData[] = $line;
            }
        }

        $data = $newData;
    }

    /**
     * Optimize same lines.
     */
    $prevLine = null;
    foreach ($data as $i => $row) {
        /**
         * Remove echos.
         */
        if (strpos($row, '  echo ') === 0) {
            unset($data[$i]);
        } else if ($prevLine === $row) {
            unset($data[$i]);
        }
        $prevLine = $row;
    }

    /**
     * Merge installs.
     */
    $installs = [];
    $newData = [];
    foreach ($data as $line) {
        if (strpos($line, 'apt-get install') !== false) {
            $installs[] = $line;
            continue;
        }
        if ($installs) {
            $allInstals = implode(" ", $installs);
            $allInstals = str_replace('apt-get install -y ', '', $allInstals);
            $exploded = explode(" ", $allInstals);
            $unique = array_unique($exploded);
            $newData[] = 'apt-get install -y ' . implode(" ", $unique);
            $installs = [];
        }
        $newData[] = $line;
    }
    $data = $newData;

    /**
     * Merge npm installs.
     */
    $installs = [];
    $newData = [];
    foreach ($data as $line) {
        if (strpos($line, 'npm install -g') !== false) {
            $installs[] = $line;
            continue;
        }
        if ($installs) {
            $allInstals = implode(" ", $installs);
            $allInstals = str_replace('npm install -g ', '', $allInstals);
            $exploded = explode(" ", $allInstals);
            $unique = array_unique($exploded);
            $newData[] = 'npm install -g ' . implode(" ", $unique);
            $installs = [];
        }
        $newData[] = $line;
    }
    $data = $newData;

    return $data;
}

$data = [];
$temp = [];
foreach ($lines as $line) {
    /**
     * Skip "nonsense".
     */
    if (!$line || strpos($line, '#') === 0) {
        continue;
    }

    if (substr($line, 0, 3) !== 'RUN') {
        if ($temp) {
            $temp[] = 'rm -rf /var/lib/apt/lists/*';
            $temp[] = 'rm -rf /usr/local/pckg-utils';
            $data[] = 'RUN ' . implode(" \\\n\t&& ", optimizeFlow($temp));
            $temp = [];
        }
        $data[] = $line;

        continue;
    }

    if (substr($line, 0, 7) !== 'RUN sh ') {
        $temp[] = substr($line, 4);
        continue;
    }

    $subcontent = file_get_contents($dir . str_replace('/usr/local/pckg-', '', substr($line, 7)));
    foreach (explode("\n", $subcontent) as $subline) {
        /**
         * Skip "nonsense".
         */
        if (!$subline || strpos($subline, '#') === 0) {
            continue;
        }
        if (strpos($subline, 'sh /usr/local/pckg-utils/') === 0) {
            $temp[] = '  echo "Running ' . $subline . '"';
            $subsubcontent = file_get_contents($dir . str_replace('/usr/local/pckg-', '', substr($subline, 3)));
            foreach (explode("\n", $subsubcontent) as $subsubline) {
                if (!$subsubline || strpos($subsubline, '#') === 0) {
                    continue;
                }

                if (strpos($subsubline, 'sh /usr/local/pckg-utils/') === 0) {
                    $temp[] = '  echo "Running ' . $subsubline . '"';
                    $subsubsubcontent = file_get_contents($dir . str_replace('/usr/local/pckg-', '', substr($subsubline, 3)));
                    foreach (explode("\n", $subsubsubcontent) as $subsubsubline) {
                        if (!$subsubsubline || strpos($subsubsubline, '#') === 0) {
                            continue;
                        }
                        $temp[] = replaceAlpine($subsubsubline);
                    }
                    continue;
                }
                $temp[] = replaceAlpine($subsubline);
            }
            continue;
        }
        $temp[] = replaceAlpine($subline);
    }
}

$data = implode("\n", $data);

if ($apk) {
    $data = str_replace([
        'ubuntu:20.04',
        'schtr4jh/pckg:base',
        'apt-get -y update',
        'apt-get install -y',
        ' apt-utils',
        ' gnupg-agent',
        ' locales',
        ' software-properties-common',
        ' apt-transport-https',
        'locale-gen en_US.UTF-8',
        'dpkg-reconfigure -f noninteractive tzdata',
        'add-apt-repository ppa:ondrej/php',
        'add-apt-repository ppa:ondrej/apache2',
    ], [
        'alpine',
        'schtr4jh/pckg:base-alpine',
        'apk update',
        'apk add',
        '',
        '',
        '',
        '',
        '',
        'date',
        'date',
        'apk add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community',
        'date',
    ], $data);
}

file_put_contents($dir . $file . '-build' . ($apk ? '-alpine' : ''), $data);

echo "Done";