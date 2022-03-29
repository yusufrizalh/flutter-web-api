<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Max-Age: 86400');
header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');
header('Access-Control-Expose-Headers: Content-Length, X-JSON');

include "./db.php";

$name = $_POST['name'];
$age = (int) $_POST['age'];

$stmt = $db->prepare("INSERT INTO tbl_students (name, age) VALUES (?, ?)");
$result = $stmt->execute([$name, $age]);
echo json_encode([
    'success' => $result
]);
