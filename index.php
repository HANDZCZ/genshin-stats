<?php


$KEY = "";


// Don't edit anything after this comment


if (isset($_FILES["file"]) && isset($_POST["key"]) && $_POST["key"] == $KEY) {
    $filepath = $_FILES['file']['tmp_name'];
    $fileSize = filesize($filepath);
    $fileinfo = finfo_open(FILEINFO_MIME_TYPE);
    $filetype = finfo_file($fileinfo, $filepath);

    if ($fileSize === 0 && $fileSize > 3145728) {
        echo "RIP FILE";
    }

    $newFilepath = "page.html";

    if (!copy($filepath, $newFilepath)) {
        die("Can't move file.");
    }
    unlink($filepath);

    echo "File uploaded successfully :)";
} else {
    $page = file_get_contents("page.html");
    echo $page;
}
?>