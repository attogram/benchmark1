<?php
if ($argc != 2) {
    echo "Usage: php " . $argv[0] . " <iterations>\n";
    exit(1);
}

$iterations = (int)$argv[1];

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    microtime(true);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";
