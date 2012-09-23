<?php
// Connecting and setting values
$dbconn = pg_connect("host=localhost dbname=bikesearch user=postgres password=postgres")
    or die('Could not connect: ' . pg_last_error());

// SQL Query

$search = $_POST['search'];

$query = "SELECT trademark, model, url, prize FROM bikes WHERE model ~ '$search' OR trademark ~ '$search'";

$result = pg_query($query) or die('Query returned an error: ' . pg_last_error());

// HTML Results Print
echo "<table>\n";
while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        echo "\t\t<td>$col_value</td>\n";
    }
    echo "\t</tr>\n";
}
echo "</table>\n";

// Freeing result
pg_free_result($result);

// Closing connection
pg_close($dbconn);
?>

