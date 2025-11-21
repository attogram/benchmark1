<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <seconds_to_subtract> <iterations>\n";
    exit(1);
}

$seconds_to_subtract = (int)$argv[1];
$iterations = (int)$argv[2];
$sum = 0;

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    $time = time();
    $time -= $seconds_to_subtract;
    $sum += $time;
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

// Use the result to prevent dead code elimination
if ($sum < 0) {
    echo "Impossible sum\n";
}
