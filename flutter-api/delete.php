<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Max-Age: 86400');
header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
header('Access-Control-Expose-Headers: Content-Length, X-JSON');

include "./db.php";

$id = (int) $_POST['id'];
$stmt = $db->prepare("DELETE FROM tbl_students WHERE id = ?");
$result = $stmt->execute([$id]);
echo json_encode([
    'id' => $id,
    'success' => $result
]);
