<?php
if (defined('PINCHOSFW'))
{
    require_once (SYSTEM_FOLDER . 'Model.php');

    class ModeloConcurso extends Model {
        /**
        * Consulta las bases de un concurso en la base de datos.
        */
        public function consultarBases ($idconcurso) {

            $qresult = $this->db->query("SELECT bases FROM concursos WHERE id=1");

            if ($qresult && $qresult->num_rows == 1) {
                return $qresult->fetch_assoc()['bases'];
            }
            else {
                return FALSE;
            }
        }
    };
}
else
{
    header("HTTP/1.0 404 Not Found");
}
?>
