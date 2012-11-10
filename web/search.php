<?php
// Global variables
$http_line = "http://" ;

// Connecting and setting values
$dbconn = pg_connect("host=localhost dbname=bikesearch user=postgres password=postgres123")
    or die('Could not connect: ' . pg_last_error());

// SQL Query
$search    = $_POST['search'];
$searchGet = $_GET['search'];
$priceFrom = $_POST['priceFrom'];
$priceTo   = $_POST['priceTo'];
$type      = $_POST['type'];

// HTML Results Print

echo "<!DOCTYPE HTML>\n";
echo "<html>\n";
echo "\n";
echo "<head>\n";
echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n";
echo "<title>Buscador de Bicicletas - Comprar Bici - Buscar</title>\n";
echo "<link rel=\"stylesheet\" href=\"bikesearch.css\" type=\"text/css\">\n";
echo "</head>\n";

if ( !$search) {
  $search=$searchGet;
}

if (   ((!$search)    || (strlen($search)==0))
    && ((!$priceFrom) || (strlen($priceFrom)==0)) 
    && ((!$priceTo)   || (strlen($priceTo)==0))   ) {
  echo "<section id=\"search_error\">\n";
  echo "<p>B&uacute;squeda vac&iacute;a</p>\n";
  echo "</section>\n";
  echo "</html>\n";
  exit();
}

if (($priceFrom >= $priceTo) && ($priceFrom) && ($priceTo)) {
  echo "<section id=\"search_error\">\n";
  echo "<p>B&uacute;squeda errónea. Por favor, especfique un rango de precios v&aacute;lidos.</p>\n";
  echo "</section>\n";
  echo "</html>\n";
  exit();
}

$search_array=str_word_count($search, 1, '0123456789-/.');
$query = "SELECT trademark, model, kind, CAST(price AS decimal(10,2)), store, url FROM bikes ";
$round = 0;
$num_results = 0;
foreach ($search_array as $subsearch) {
    if ($round == 0) {
      $query .= "WHERE ";
    }
    else {
      $query .= "AND ";
    }
    $query .= "(LOWER(model) ~ LOWER('$subsearch') OR LOWER(trademark) ~ LOWER('$subsearch')) ";
    $round = $round + 1;
} 

if (($priceFrom < $priceTo)) {
  if($search) {
    if($type) {
      $query .= "AND (price <= '$priceTo' AND price >= '$priceFrom') AND kind ~ '$type' ORDER BY price;";
    }
    else {
      $query .= "AND (price <= '$priceTo' AND price >= '$priceFrom') ORDER BY price;";
    }
  }
  else {
    if($type) {
      $query .= "WHERE (price <= '$priceTo' AND price >= '$priceFrom') AND kind ~ '$type' ORDER BY price;";
    }
    else {
      $query .= "WHERE (price <= '$priceTo' AND price >= '$priceFrom') ORDER BY price;";
    }
  }
}
else {
  $query .= "ORDER BY price;";
}

// echo "<p>QUERY:=>$query<=</p>\n";
$result = pg_query($query) or die('Query returned an error: ' . pg_last_error());
// echo "<p>RESULT:=>$result<=</p>\n";

// echo "<section id=\"search_results\">\n";
echo "<section>\n";
echo "<table class=\"tableSearch\">\n";

$round = 0;

while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    $num_results += 1;
    if ($round== 0)
    {
        echo "\t<thead>\n";
        echo "\t<tr>\n";
	echo "\t<td><b>Marca</b></td>\n";
        echo "\t<td><b>Modelo</b></td>\n";
        echo "\t<td><b>Tipo</b></td>\n";
        echo "\t<td><b>Precio</b></td>\n";
        echo "\t<td><b>Tienda</b></td>\n";
        echo "\t<td><b>Enlace</b></td>\n";
        echo "\t</tr>\n";
        echo "\t</thead>\n";
        echo "\t<tbody>\n";
    }
    echo "\t<tr>\n";
    $round = 0;
    foreach ($line as $col_value) {
        $compare_len = strlen($http_line);
        $islink = substr($col_value, 0, $compare_len);
        if($round == 0) {
          $trademark = $col_value;
        }
        if($round == 1) {
          $model = $col_value;
        }

        if ( strcmp($islink, $http_line) == 0 ) {
          echo "\t\t<td><a href=\"$col_value\" target=\"_blank\">$trademark - $model</a></td>\n";
        }
        else {
          if ( strcmp($col_value, "URBAN-CONFORT-FOLDING") == 0 ) {
            echo "\t\t<td>URBAN</td>\n";
          }
          else { 
            echo "\t\t<td>$col_value</td>\n";
          }
        }
	$round = $round+1;
    }
    echo "\t</tr>\n";
}
echo "\t</tbody>\n";
echo "</table>\n";    
echo "</section>\n";
if ($round==0) {
          echo "<section id=\"search_error\">\n";
          echo "<p>Sin resultados</p>\n";
          echo "</section>\n";
          echo "</html>\n";
          exit();
}
if ($num_results!=0) {
          echo "<section id=\"num_results\">\n";
          echo "<p>N&uacute;mero de resultados:$num_results</p>\n";
          echo "</section>\n";
          echo "</html>\n";
          exit();
}

// Freeing result
pg_free_result($result);

// Closing connection
pg_close($dbconn);
?>
