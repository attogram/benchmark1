<?php
if ($argc != 5) {
    echo "Usage: php " . $argv[0] . " <string> <start> <length> <iterations>\n";
    exit(1);
}

$string = $argv[1];
$start_pos = (int)$argv[2];
$length = (int)$argv[3];
$iterations = (int)$argv[4];
$total_length = 0;

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    $sub = substr($string, $start_pos, $length);
    $total_length += strlen($sub);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

// Use the result to prevent dead code elimination
if ($total_length < 0) {
    echo "Impossible length\n";
}
