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

if(isset($_POST['email'])) {

    echo "<!DOCTYPE HTML>\n";
    echo "<html>\n";
    echo "\n";
    echo "<head>\n";
    echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n";
    echo "<title>Buscador de Bicicletas - Comprar Bici - Contactar</title>\n";
    echo "<link rel=\"stylesheet\" href=\"bikesearch.css\" type=\"text/css\">\n";
    echo "</head>\n";
     
    // EDIT THE 2 LINES BELOW AS REQUIRED
    $email_to = "buscobici.com@gmail.com";
    $email_subject = "Mensaje desde buscobici.com";
     
    function died($error) {
        echo "<section id=\"contact_error\">\n";
        echo "<p>Lo sentimos. ";
        echo "Se produjo el siguiente error:<br /><br />";
        echo $error."<br /><br />";
        echo "<br /><br />";
        echo "</p>";
        echo "</section>\n";
        echo "</html>\n";
        exit();
    }
     
    // validation expected data exists
    if( !isset($_POST['first_name']) ||
        !isset($_POST['last_name'])  ||
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
  if((strlen($last_name)) <= 0) {
    $error_message .= '- El apellido es obligatorio<br />';
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
  $email_message .= "Apellido : ".clean_string($last_name)."\n";
  $email_message .= "Email : ".clean_string($email_from)."\n";
  $email_message .= "Comentarios : ".clean_string($comments)."\n";
     
  // create email headers
  $headers = 'From: '.$email_from."\r\n".
  'Reply-To: '.$email_from."\r\n" .
  'X-Mailer: PHP/' . phpversion();
  @mail($email_to, $email_subject, $email_message, $headers); 
?>
 
<!-- include your own success html here -->
<html>
<body>
<section id="contact_result">
  <p> Gracias por contactarnos. <br/>
      Le responderemos en breve.<br/>
      Un saludo.<br/>
  </p>
</section>
</body>
</html>
<?php
}
?>
