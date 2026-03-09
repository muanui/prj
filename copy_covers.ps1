$brain = 'C:\Users\OS\.gemini\antigravity\brain\a2534c3e-7149-4617-a1cd-0e1faf88768b'
$dest = 'c:\Users\OS\Documents\NetBeansProjects\BookApp\web\images'

$map = @{
    'trai_hoa_do'             = 'trai-hoa-do.jpg'
    'chi_pheo'                = 'chi-pheo.jpg'
    'canh_dong_bat_tan'       = 'canh-dong-bat-tan.jpg'
    'chuyen_tinh_new_york'    = 'chuyen-tinh-new-york.jpg'
    'viet_nam_su_luoc'        = 'viet-nam-su-luoc.jpg'
    'lich_su_the_gioi_co_dai' = 'lich-su-the-gioi-co-dai.jpg'
}

foreach ($prefix in $map.Keys) {
    $png = Get-ChildItem -Path $brain -Filter "$($prefix)*.png" | Select-Object -First 1
    if ($png) {
        $outFile = Join-Path $dest $map[$prefix]
        Copy-Item $png.FullName -Destination $outFile -Force
        Write-Host "Copied: $($png.Name) -> $($map[$prefix])"
    }
    else {
        Write-Host "NOT FOUND: $prefix"
    }
}
Write-Host "=== Copy Done ==="
