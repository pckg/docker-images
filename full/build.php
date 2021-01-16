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
            $data[] = 'RUN ' . implode(" \\\n\t&& ", $temp);
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