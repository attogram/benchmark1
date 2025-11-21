<?php
if ($argc != 5) {
    echo "Usage: php " . $argv[0] . " <string> <start> <length> <iterations>\n";
    exit(1);
}

$string = $argv[1];
$start_pos = (int)$argv[2];
$length = (int)$argv[3];
$iterations = (int)$argv[4];

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    substr($string, $start_pos, $length);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";
