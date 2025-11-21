<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <hex_string> <iterations>\n";
    exit(1);
}

$hex_string = $argv[1];
$iterations = (int)$argv[2];

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    hexdec($hex_string);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";
