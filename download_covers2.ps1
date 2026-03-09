$dest = "c:\Users\OS\Documents\NetBeansProjects\BookApp\web\images"

# Thử ISBN khác / nguồn khác cho các sách bị skip
$books = @(
    # nha-gia-kim - ISBN tiếng Anh
    @{isbn = "9780062315007"; file = "nha-gia-kim.jpg" },
    # hoa-vang - không có ISBN trên OL, dùng OLID
    @{url = "https://covers.openlibrary.org/b/olid/OL24366578M-L.jpg"; file = "hoa-vang.jpg" },
    # chuyen-tinh-new-york
    @{isbn = "9782253008163"; file = "chuyen-tinh-new-york.jpg" },
    # mat-biec
    @{url = "https://covers.openlibrary.org/b/olid/OL26438936M-L.jpg"; file = "mat-biec.jpg" },
    # trai-hoa-do
    @{isbn = "9786041031494"; file = "trai-hoa-do.jpg"; fallback = "https://m.media-amazon.com/images/I/71i-5OIQXML._AC_UF1000,1000_QL80_.jpg" },
    # nick-vujicic
    @{isbn = "9780307589743"; file = "nick-vujicic.jpg" },
    # chi-pheo
    @{url = "https://covers.openlibrary.org/b/olid/OL34520553M-L.jpg"; file = "chi-pheo.jpg" },
    # canh-dong-bat-tan
    @{url = "https://covers.openlibrary.org/b/olid/OL25390566M-L.jpg"; file = "canh-dong-bat-tan.jpg" },
    # viet-nam-su-luoc
    @{isbn = "9786041220461"; file = "viet-nam-su-luoc.jpg" },
    # lich-su-the-gioi-co-dai
    @{isbn = "9785050034083"; file = "lich-su-the-gioi-co-dai.jpg" },
    # khao-luan-chinh-phu
    @{isbn = "9780486424644"; file = "khao-luan-chinh-phu.jpg" }
)

foreach ($b in $books) {
    $out = Join-Path $dest $b.file
    if ((Test-Path $out) -and (Get-Item $out).Length -gt 5000) {
        Write-Host "SKIP(exists): $($b.file)"; continue
    }

    if ($b.url) {
        $url = $b.url
    }
    else {
        $url = "https://covers.openlibrary.org/b/isbn/$($b.isbn)-L.jpg"
    }

    try {
        Invoke-WebRequest -Uri $url -OutFile $out -TimeoutSec 15 -ErrorAction Stop
        $size = (Get-Item $out).Length
        if ($size -lt 5000) {
            Remove-Item $out -Force
            Write-Host "SMALL: $($b.file) ($size bytes)"
        }
        else {
            Write-Host "OK: $($b.file) ($size bytes)"
        }
    }
    catch {
        Write-Host "ERR: $($b.file) - $_"
    }
}
Write-Host "=== Pass 2 Done ==="
