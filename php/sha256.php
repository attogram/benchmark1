<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <string> <iterations>\n";
    exit(1);
}

$string = $argv[1];
$iterations = (int)$argv[2];
$total_length = 0;

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    $hash = hash('sha256', $string);
    $total_length += strlen($hash);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

// Use the result to prevent dead code elimination
if ($total_length < 0) {
    echo "Impossible length\n";
}
