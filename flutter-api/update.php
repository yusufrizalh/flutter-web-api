<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Max-Age: 86400');
header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
header('Access-Control-Expose-Headers: Content-Length, X-JSON');

include "./db.php";

$id = $_POST['id'];
$name = $_POST['name'];
$age = (int) $_POST['age'];

$stmt = $db->prepare("UPDATE tbl_students SET name = ?, age = ? WHERE id = ?");
$result =  $stmt->execute([$name, $age, $id]);
echo json_encode([
    'success' => $result
]);
