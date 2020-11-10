<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

$file = $argv[1];
$dir = __DIR__ . '/';

$content = file_get_contents($dir . $file);
$lines = explode("\n", $content);

function replaceAlpine($s) {
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

file_put_contents($dir . $file . '-build', $data);

echo "Done";