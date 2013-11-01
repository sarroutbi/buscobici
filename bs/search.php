<?php 
/**
 * Copyright © 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
 * 
 * Permission to use, copy, modify, and/or distribute this software 
 * for any purpose with or without fee is hereby granted, provided that 
 * the above copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, 
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM 
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
 * OR PERFORMANCE OF THIS SOFTWARE.
 */

// Global variables
$http_line = "http://" ;

// Connecting and setting values
$dbconn = pg_connect("host=localhost dbname=bikesearch user=postgres password=postgres123")
    or die('Could not connect: ' . pg_last_error());

// SQL Query
$search          = $_POST['search'];
$priceFrom       = $_POST['priceFrom'];
$priceTo         = $_POST['priceTo'];
$type            = $_POST['type'];
$page            = $_POST['page'];
$numResults      = $_POST['numResults'];
$entryPerPage    = $_POST['entryPerPage'];
$searchGet       = $_GET['search'];
$priceFromGet    = $_GET['priceFrom'];
$priceToGet      = $_GET['priceTo'];
$typeGet         = $_GET['type'];
$pageGet         = $_GET['page'];
$numResultsGet   = $_GET['numResults'];
$entryPerPageGet = $_GET['entryPerPage'];

// Default Num. of results per page
$defaultResultsPerPage = 15;
$defaultAroundPages    = 2;
$defaultFirstPages     = 5;
$defaultLastPages      = 5;
$defaultMaxModel       = 25;

if ( ($numResultsGet     && ($numResultsGet   != "" )) ||
     ($numResults        && ($numResults      != "" )) ||
     ($entryPerPage      && ($entryPerPage    != "" )) || 
     ($entryPerPageGet   && ($entryPerPageGet != "" )) )  {
  if ($numResults && ($numResults != ""))
    $resultsPerPage = $numResults;
  else if ($numResultsGet && ($numResultsGet != "")) 
    $resultsPerPage = $numResultsGet;
  else if ($entryPerPage && ($entryPerPage != ""))
    $resultsPerPage = $entryPerPage;
  else if ($entryPerPageGet && ($entryPerPageGet != ""))
    $resultsPerPage = $entryPerPageGet;
}
else {
  $resultsPerPage = $defaultResultsPerPage;
}

// Actual page
if($pageGet  && ($pageGet != ""))
  $page = $pageGet;
else if(!$page  || ($page == ""))
  $page = 1;

// HTML Results Print

echo "<!DOCTYPE HTML>\n";
echo "<html lang=\"es\">\n";
echo "<head>\n";
echo "\n";
echo "<title>buscobici.com - Buscador de Bicicletas</title>\n";
echo "<link href=\"./css/bootstrap.css\" rel=\"stylesheet\">\n";
echo "\n";
echo "<link href=\"./css/justified-nav.css\" rel=\"stylesheet\">\n";
echo "\n";
echo "<link href=\"./css/signin.css\" rel=\"stylesheet\">\n";
echo "<script type=\"text/javascript\">\n";
echo "  var _gaq = _gaq || [];\n";
echo "  _gaq.push(['_setAccount', 'UA-35382693-4']);\n";
echo "  _gaq.push(['_trackPageview']);\n";
echo "\n";
echo "  (function() {\n";
echo "    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;\n";
echo "    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';\n";
echo "    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);\n";
echo "  })();\n";
echo "</script>\n";

echo "</head>\n";

echo "<body>\n";

// echo "<p>=============== POST =================</p>\n";
// echo "<p>search:=>$search<=</p>";
// echo "<p>PriceFrom:=>$priceFrom<=</p>";
// echo "<p>PriceTo:=>$priceTo<=</p>";
// echo "<p>Type:=>$type<=</p>";
// echo "<p>Entries per page:=>$entryPerPage<=</p>";
// echo "<p>Results per page:=>$resultsPerPage<=</p>";
// echo "<p>=============== POST ==================</p>\n";
// echo "<p>=============== GET  =================</p>";
// echo "<p>searchGet:=>$searchGet<=</p>";
// echo "<p>PriceFrom:=>$priceFromGet<=</p>";
// echo "<p>PriceTo:=>$priceToGet<=</p>";
// echo "<p>Type:=>$typeGet<=</p>";
// echo "<p>Entries per page:=>$entryPerPageGet<=</p>";
// echo "<p>Results per page:=>$resultsPerPage<=</p>";
// echo "<p>=============== GET ==================</p>\n";
// echo "<section id=\"search_results\">\n";
// echo "<section id=\"search_results\">\n";

if ( !$search) {
  $search=$searchGet;
}
if ( !$priceFrom) {
  $priceFrom=$priceFromGet;
  if (!$priceFrom)
    $priceFrom=0;
  if (!$priceFrom && ($priceTo>0))
    $priceFrom=0;
}
if ( !$priceTo) {
  $priceTo=$priceToGet;
  if (!priceTo)
    $priceTo=0;
}
if ( !$type) {
  $type=$typeGet;
}

if (   ((!$search)    || (strlen($search)==0))
    && ((!$priceFrom) || (strlen($priceFrom)==0)) 
    && ((!$priceTo)   || (strlen($priceTo)==0))   
    && ((!$type)      || (strlen($type)==0))   
    ) {
  echo "\n";
  echo "\n";
  echo "<div class=\"container\">\n";
  echo "\n";
  echo "  <div class=\"masthead\">\n";
  echo "    <a href=\"index.html\">\n";
  echo "      <img src=\"res/logo-med.png\" class=\"img-responsive\" alt=\"Responsive image\">\n";
  echo "    </a>\n";
  echo "    <ul class=\"nav nav-justified\">\n";
  echo "      <li><a href=\"index.html\">Búsqueda</a></li>\n";
  echo "      <li><a href=\"byprice.html\">Búsq.Avzda.</a></li>\n";
  echo "      <li><a href=\"http://buscobici.com/forum\">Foros</a></li>\n";
  echo "      <li><a href=\"http://buscobici.com/bikesearch/stats_fullscreen.html\">Estadísticas</a></li>\n";
  echo "      <li><a href=\"contact.html\">Contactar</a></li>\n";
  echo "    </ul>\n";

  echo "    <div class=\"well\">\n";
  echo "      <p>¿Vas a comprar una bicicleta? Compara entre 8000 bicicletas de las principales marcas en diversas tiendas on-line: Trek, Specialized, Giant, Merida, Scott, Cube, Bmc, Lapierre, Cervélo, Mondraker, Orbea, Bh, Conor, Gt, Ghost, Fuji, ...</p>\n";
  echo "    </div>\n";
  echo "\n";
  echo "    <!-- Jumbotron -->\n";
  echo "    <div class=\"jumbotron\">\n";
  echo "      <p>B&uacute;squeda vac&iacute;a</p>\n";
  echo "    </div>\n";
  echo "  </div>\n";
  echo "</div>\n";
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


$search = preg_replace('/[^a-zA-Z0-9\ \.]/i', null, $search);

$search_array=str_word_count($search, 1, '0123456789-/.');
$start = ($page - 1) * $resultsPerPage;
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
      $query .= "AND (price <= '$priceTo' AND price >= '$priceFrom') AND kind ~ '$type' ORDER BY price";
    }
    else {
      $query .= "AND (price <= '$priceTo' AND price >= '$priceFrom') ORDER BY price";
    }
  }
  else {
    if($type) {
      $query .= "WHERE (price <= '$priceTo' AND price >= '$priceFrom') AND kind ~ '$type' ORDER BY price";
    }
    else {
      $query .= "WHERE (price <= '$priceTo' AND price >= '$priceFrom') ORDER BY price";
    }
  }
}
else {
  if($search) {
    if($type) {
      $query .= "AND kind ~ '$type' ORDER BY price";
    }
    else {
      $query .= "ORDER BY price";
    }
  } 
  else {
    if($type) {
      $query .= "WHERE kind ~ '$type' ORDER BY price";
    }
    else {
      $query .= "ORDER BY price";
    }
  }
}

$query_limited = $query . " LIMIT $resultsPerPage OFFSET $start;";
$query .= ";";

// echo "<p>=============== POST =================</p>\n";
// echo "<p>QUERY:=>$query<=</p>";
// echo "<p>QUERY LIMITED:=>$query_limited<=</p>";
// echo "<p>RESULT:=>$result<=</p>";
// echo "<p>=============== POST ==================</p>\n";
// echo "<p>=============== GET  =================</p>";
// echo "<p>QUERY:=>$queryGet<=</p>";
// echo "<p>QUERY LIMITED:=>$query_limited<=</p>";
// echo "<p>RESULT:=>$result<=</p>";
// echo "<p>=============== GET ==================</p>\n";

$result = pg_query($query) or die('Query returned an error: ' . pg_last_error());

echo "<div class=\"container\">\n";
echo "\n";
echo "  <div class=\"masthead\">\n";
echo "    <a href=\"index.html\">\n";
echo "      <img src=\"res/logo-med.png\" class=\"img-responsive\" alt=\"Responsive image\">\n";
echo "    </a>\n";
echo "    <ul class=\"nav nav-justified\">\n";
echo "      <li><a href=\"index.html\">Búsqueda</a></li>\n";
echo "      <li><a href=\"byprice.html\">Búsq.Avzda.</a></li>\n";
echo "      <li><a href=\"http://buscobici.com/forum\">Foros</a></li>\n";
echo "      <li><a href=\"http://buscobici.com/bikesearch/stats_fullscreen.html\">Estadísticas</a></li>\n";
echo "      <li><a href=\"contact.html\">Contactar</a></li>\n";
echo "    </ul>\n";
echo "\n";
echo "  </div>\n";
echo "</div>\n";

$round = 0;

$num_results = pg_numrows($result);
$num_pages = ceil($num_results / $resultsPerPage);
$result = pg_query($query_limited) or die('Query returned an error: ' . pg_last_error());

echo "<table class=\"tableSearch\">\n";

while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    if ($round== 0)
    {
        echo "\t<thead>\n";
        echo "\t<tr id=\"search_results\">\n";
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
          $trademark_trim = trim($trademark);
        }
        if($round == 1) {
          $model = $col_value;
          $limited_model = $model;
          if (strlen($model) > $defaultMaxModel) {
            $limited_model = substr($model, 0, $defaultMaxModel-3);
            $limited_model .= "...";
            $col_value = $limited_model;
          }
        }
        if ( strcmp($islink, $http_line) == 0 ) {
          echo "\t\t<td><a href=\"$col_value\" target=\"_blank\">$trademark_trim - $limited_model</a></td>\n";
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
  echo "    <!-- Jumbotron -->\n";
  echo "    <div class=\"jumbotron\">\n";
  echo "      <p>Lo sentimos, no se encontr&oacute; ning&uacute;n resultado</p>\n";
  echo "    </div>\n";
}

if ($num_results > 0) {
    echo "<section id=\"page_results\">\n";
    echo "<form method=\"post\" action=\"search.php?page=1&type=$type&priceFrom=$priceFrom&priceTo=$priceTo&search=$search&entryPerPage=$resultsPerPage\" name=\"form\">";

    echo "<p>N&uacute;mero total de resultados:$num_results";
    if ($num_results!=0) {
      if (($num_pages) > 1) {
        echo " - Mostrando p&aacute;gina:$page/$num_pages - ";
        $plotsMinPainted = false;
        $plotsMaxPainted = false;
        $pending_page = 1;
        if ($page != 1) {
          $prev_page = $page-1;
          echo "<a href=\"search.php?page=$prev_page&type=$type&priceFrom=$priceFrom&priceTo=$priceTo&search=$search&entryPerPage=$resultsPerPage\">&lt;&lt;&lt;</a>\n";
          echo " - ";
        }
        while ( $pending_page <= $num_pages) {
          if( ($pending_page <= ($page + $defaultAroundPages)) && ($pending_page >= ($page - $defaultAroundPages)) ||
              ($pending_page <= $defaultFirstPages) || ($pending_page > ($num_pages - $defaultLastPages)) ) {
            if ($page == $pending_page) {
              echo "<b>$pending_page</b>\n";
            }
            else {
              echo "<a href=\"search.php?page=$pending_page&type=$type&priceFrom=$priceFrom&priceTo=$priceTo&search=$search&entryPerPage=$resultsPerPage\">$pending_page</a>\n";
            }
          }
          else {
            if(($pending_page > $defaultFirstPages) && ($pending_page < ($page - $defaultAroundPages)) ) {
              if (!$plotsMinPainted) {
                echo " ... ";
                $plotsMinPainted = true;
              }
            }
            if($pending_page < ($num_pages - $defaultLastPages) && ($pending_page > ($page + $defaultAroundPages)) ) { 
              if (!$plotsMaxPainted) {
                echo " ... ";
                $plotsMaxPainted = true;
              }
            }
          }
          $pending_page++;
        }
        if ($page != $num_pages) {
          $next_page = $page+1;
          echo " - ";
          echo "<a href=\"search.php?page=$next_page&type=$type&priceFrom=$priceFrom&priceTo=$priceTo&search=$search&entryPerPage=$resultsPerPage\">&gt;&gt;&gt;</a>\n";
          echo " ";
        }
        if (($num_pages) > 1) {
          echo "<label> - Entradas por p&aacute;gina :</label>\n";
          echo "<select name=\"entryPerPage\" id=\"entryPerPage\" onSelect=\"form.submit()\" onChange=\"form.submit()\">\n";
          if ($resultsPerPage == 10) 
            echo "  <option value=\"10\" selected=\"selected\">10</option>\n";
	  else 
            echo "  <option value=\"10\">10</option>\n";
          if ($resultsPerPage == 15) 
            echo "  <option value=\"15\" selected=\"selected\">15</option>\n";
	  else 
            echo "  <option value=\"15\">15</option>\n";
          if ($resultsPerPage == 20) 
            echo "  <option value=\"20\" selected=\"selected\">20</option>\n";
	  else 
            echo "  <option value=\"20\">20</option>\n";
          if ($resultsPerPage == 25) 
            echo "  <option value=\"25\" selected=\"selected\">25</option>\n";
          else
            echo "  <option value=\"25\">25</option>\n";
          if ($resultsPerPage == 50)
            echo "  <option value=\"50\" selected=\"selected\">50</option>\n";
          else
            echo "  <option value=\"50\">50</option>\n";
          if ($resultsPerPage == 100)
            echo "  <option value=\"100\" selected=\"selected\">100</option>\n";
          else
            echo "  <option value=\"100\">100</option>\n";
          echo "</select>\n";
        }
      }
      echo "</p>";
      echo "</section>\n";
      // echo "<input id =\"submit2\" name=\"submit\" type=\"submit\" value=\"Actualizar\">\n";
      echo "</form>\n";
    }
}

echo "<div class=\"footer\">\n";
echo "  <p>S&iacute;guenos :&nbsp; \n";
echo "    <a href=\"http://www.facebook.com/buscobicidotcom\" target=\"_blank\">\n";
echo "      <img src=\"res/facebook00.jpg\" alt=\"Facebook\"/>\n";
echo "    </a>\n";
echo "    <a href=\"http://www.twitter.com/buscobici\" target=\"_blank\">\n";
echo "      <img src=\"res/twitter01.jpg\" alt=\"Twitter\"/> \n";
echo "    </a>\n";
echo "  </p>\n";
echo "  <p>buscobici.com 2013</p>\n";
echo "</div>\n";

echo "</body>\n";
echo "</html>\n";

// Freeing result
pg_free_result($result);

// Closing connection
pg_close($dbconn);

exit();
?>
