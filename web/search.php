<?php
// Global variables
$http_line = "http://" ;

// Connecting and setting values
$dbconn = pg_connect("host=localhost dbname=bikesearch user=postgres password=postgres")
    or die('Could not connect: ' . pg_last_error());

// SQL Query

$search = $_POST['search'];

$query = "SELECT trademark, model, prize, url FROM bikes WHERE model ~ '$search' OR trademark ~ '$search'";

$result = pg_query($query) or die('Query returned an error: ' . pg_last_error());

// HTML Results Print

echo "<!DOCTYPE HTML>\n";
echo "<html>\n";
echo "\n";
echo "<head>\n";
echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n";
echo "<title>Contact Form</title>\n";
echo "<link rel=\"stylesheet\" href=\"bikesearch.css\" type=\"text/css\">\n";
echo "</head>\n";
echo "<section id=\"search_results\">\n";
echo "<table>\n";

$pass = 0;

while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    if ($pass == 0)
    {
	echo "\t<td><b>Trademark</b></td>";
        echo "\t<td><b>Model</b></td>";
        echo "\t<td><b>Prize</b></td>";
        echo "\t<td><b>URL</b></td>\n";
        echo "\t</tr>\n";
    }
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        $compare_len = strlen($http_line);
        $islink = substr($col_value, 0, $compare_len);

        if ( strcmp($islink, $http_line) == 0 ) {
          echo "\t\t<td><a href=\"$col_value\">$col_value</a></td>\n";
        }
        else {
          echo "\t\t<td>$col_value</td>\n";
        }
	$pass = $pass+1;
    }
    echo "\t</tr>\n";
}
echo "</table>\n";    
echo "</section>\n";

// Freeing result
pg_free_result($result);

// Closing connection
pg_close($dbconn);
?>

