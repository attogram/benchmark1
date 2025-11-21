<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <string> <iterations>\n";
    exit(1);
}

$string = $argv[1];
$iterations = (int)$argv[2];

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    hash('sha256', $string);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";
