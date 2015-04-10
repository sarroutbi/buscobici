<?php
/**
 * Copyright <C2><A9> 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
 * 
 * Permission to use, copy, modify, and/or distribute this software 
 * for any purpose with or without fee is hereby granted, provided that 
 * the above copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED <E2><80><9C>AS IS<E2><80><9D> AND THE AUTHOR DISCLAIMS ALL WARRAN
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, 
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM 
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
 * OR PERFORMANCE OF THIS SOFTWARE.
 */

if(isset($_POST['email'])) {

    // HEADER                           
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

    // EDIT THE 2 LINES BELOW AS REQUIRED
    $email_to = "";
    $email_subject = "";
     
    function died($error) {
        echo "<body>\n";
        echo "  <div class=\"container\">\n";
        echo "\n";
        echo "    <div class=\"masthead\">\n";
        echo "      <a href=\"index.html\">\n";
        echo "        <img src=\"res/logo.png\" class=\"img-responsive\" alt=\"Responsive image\">\n";
        echo "      </a>\n";
        echo "      <ul class=\"nav nav-justified\">\n";
        echo "        <li><a href=\"index.html\">Búsqueda</a></li>\n";
        echo "        <li><a href=\"byprice.html\">Búsq.Avzda.</a></li>\n";
        echo "        <li><a href=\"http://buscobici.com/forum\">Foros</a></li>\n";
        echo "        <li><a href=\"http://buscobici.com/bikesearch_php_raw/stats_fullscreen.html\">Estadísticas</a></li>\n";
        echo "        <li><a href=\"contact.html\">Contactar</a></li>\n";
        echo "      </ul>\n";
                
        echo "      <div class=\"well\">\n";
        echo "        <p>¿Vas a comprar una bicicleta? Compara entre 15000 bicicletas de las principales marcas en diversas tiendas on-line: Trek, Specialized, Giant, Merida, Scott, Cube, Bmc, Lapierre, Cervélo, Mondraker, Orbea, Bh, Conor, Gt, Ghost, Fuji, ...</p>\n";
        echo "      </div>\n";
        echo "\n";
        echo "      <!-- Jumbotron -->\n";
        echo "      <div class=\"jumbotron\">\n";
        echo "        <p>Lo sentimos.  Se produjo el siguiente error:<br /><br />";
        echo "          $error<br /><br />";
        echo "        </p>";
        echo "      </div>\n";
        echo "    </div>\n";
        echo "  </div>\n";
        echo "  <div class=\"footer\">\n";
        echo "    <p>S&iacute;guenos :&nbsp; \n";
        echo "      <a href=\"http://www.facebook.com/buscobicidotcom\" target=\"_blank\">\n";
        echo "        <img src=\"res/facebook00.jpg\" alt=\"Facebook\"/>\n";
        echo "      </a>\n";
        echo "      <a href=\"http://www.twitter.com/buscobici\" target=\"_blank\">\n";
        echo "        <img src=\"res/twitter01.jpg\" alt=\"Twitter\"/> \n";
        echo "      </a>\n";
        echo "    </p>\n";
        echo "  </div>\n";
        echo "</body>\n";
        echo "</html>\n";
        exit();
    }
     
    // validation expected data exists
    if( !isset($_POST['first_name']) ||
        !isset($_POST['email']) ||
        !isset($_POST['comments'])) {
        died('Lo sentimos. Rellene todos los campos.');      
    }
     
    $first_name = $_POST['first_name']; // required
    $last_name = $_POST['last_name'];   // required
    $email_from = $_POST['email'];      // required
    $comments = $_POST['comments'];     // required
     
    $error_message = "";
    $email_exp = '/^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/';

  if((strlen($first_name)) <= 0) {
    $error_message .= '- El nombre es obligatorio<br />';
  }
  if((strlen($email_from)) <= 0) {
    $error_message .= '- La direcci&oacute;n de correo es obligatoria<br />';
  }
  else if(!preg_match($email_exp,$email_from)) {
    $error_message .= '- La direcci&oacute;n de correo no es v&aacute;lida<br />';
  }
  if((strlen($error_message)) > 0) {
    died($error_message);
  }

  $string_exp = "/^[A-Za-z .'-]+$/";
  $email_message = "Detalle de mensaje de contacto:\n\n";
     
  function clean_string($string) {
    $bad = array("content-type","bcc:","to:","cc:","href");
    return str_replace($bad,"",$string);
  }
     
  $email_message .= "Nombre : ".clean_string($first_name)."\n";
  $email_message .= "Email : ".clean_string($email_from)."\n";
  $email_message .= "Comentarios : ".clean_string($comments)."\n";

  // Check captcha
  $email;$comment;$captcha;$response;
  if(isset($_POST['g-recaptcha-response'])){
    $captcha=$_POST['g-recaptcha-response'];
  }
  if(!$captcha) {
    ;
  }
  else {
    $string="https://www.google.com/recaptcha/api/siteverify?secret=YOUR_KEY&response=".$captcha."&remoteip=".$_SERVER['REMOTE_ADDR'];
    $response=file_get_contents($string);
  }
  if(!$captcha || $response.success==false)
  {
    ; 
  }
  else if($response.success==true)
  {
    // create email headers
    $headers = 'From: '.$email_from."\r\n".
    'Reply-To: '.$email_from."\r\n" .
    'X-Mailer: PHP/' . phpversion();
    @mail($email_to, $email_subject, $email_message, $headers); 
  }
?>
 
<!-- include your own success html here -->
  <body>
      <div class="masthead">
        <a href="index.html">
          <img src="res/logo.png" class="img-responsive" alt="Responsive image">
        </a>
        <ul class="nav nav-justified">
          <li><a href="index.html">Búsqueda</a></li>
          <li><a href="byprice.html">Búsq.Avzda.</a></li>
          <li><a href="http://buscobici.com/forum">Foros</a></li>
          <li><a href="http://buscobici.com/bikesearch_php_raw/stats_fullscreen.html">Estadísticas</a></li>
          <li class="active"><a href="contact.html">Contactar</a></li>
        </ul>
      </div>
      <div class="well">
        <p>¿Vas a comprar una bicicleta? Compara entre 15000 bicicletas de las principales marcas en diversas tiendas on-line: Trek, Specialized, Giant, Merida, Scott, Cube, Bmc, Lapierre, Cervélo, Mondraker, Orbea, Bh, Conor, Gt, Ghost, Fuji, ...</p>
      </div>
      <div class="jumbotron">
        <div class="container">
          <h2>Gracias por su comentario !</h2>
          <p>Contactaremos con usted en breve</p>
        </div>
      </div>
      <!-- Site footer -->
      <div class="footer">
        <p>S&iacute;guenos :&nbsp; 
          <a href="http://www.facebook.com/buscobicidotcom" target="_blank">
            <img src="res/facebook00.jpg" alt="Facebook"/>
          </a>
          <a href="http://www.twitter.com/buscobici" target="_blank">
            <img src="res/twitter01.jpg" alt="Twitter"/> 
          </a>
        </p>
      </div>
   </body>
</html>
<?php
}
?>
