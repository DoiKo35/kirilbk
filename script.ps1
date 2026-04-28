$files = Get-ChildItem -Filter *.deb
if ($files.Count -eq 0) { 
    Write-Host "Файлы не найдены" -ForegroundColor Yellow 
} else {
    foreach ($f in $files) {
        Write-Host "--- $($f.Name) ---" -ForegroundColor Cyan
        
        # Точный размер
        $size = $f.Length
        
        # Хеши через системную библиотеку (работает везде)
        $md5Obj = [System.Security.Cryptography.MD5]::Create()
        $sha1Obj = [System.Security.Cryptography.SHA1]::Create()
        $sha256Obj = [System.Security.Cryptography.SHA256]::Create()
        
        $stream = [System.IO.File]::OpenRead($f.FullName)
        
        $md5 = [System.BitConverter]::ToString($md5Obj.ComputeHash($stream)).Replace("-","").ToLower()
        $null = $stream.Seek(0, 0)
        $sha1 = [System.BitConverter]::ToString($sha1Obj.ComputeHash($stream)).Replace("-","").ToLower()
        $null = $stream.Seek(0, 0)
        $sha256 = [System.BitConverter]::ToString($sha256Obj.ComputeHash($stream)).Replace("-","").ToLower()
        
        $stream.Close()

        Write-Host "Size: $size"
        Write-Host "MD5sum: $md5"
        Write-Host "SHA1: $sha1"
        Write-Host "SHA256: $sha256"
        Write-Host ""
    }
}
Write-Host "Нажми Enter..."
[void][Console]::ReadLine()