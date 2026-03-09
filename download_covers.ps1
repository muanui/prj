$dest = "c:\Users\OS\Documents\NetBeansProjects\BookApp\web\images"

# ISBN => filename  (Open Library Covers API: https://covers.openlibrary.org/b/isbn/{ISBN}-L.jpg)
$books = @(
    # Tieu thuyet
    @{isbn="9786041071834"; file="nha-gia-kim.jpg"},
    @{isbn="9780743273565"; file="dac-nhan-tam.jpg"},
    @{isbn="9786041040625"; file="hoa-vang.jpg"},
    # Trinh Tham
    @{isbn="9780007119318"; file="tau-toc-hanh.jpg"},
    @{isbn="9780307269751"; file="sherlock-holmes.jpg"},
    @{isbn="9780307588371"; file="co-gai-mat-tich.jpg"},
    # Tinh cam
    @{isbn="9782221108178"; file="chuyen-tinh-new-york.jpg"},
    @{isbn="9786041075283"; file="mat-biec.jpg"},
    @{isbn="9781455582877"; file="nguoi-trong-coi.jpg"},
    # Khoa hoc vien tuong
    @{isbn="9780441013593"; file="dune.jpg"},
    @{isbn="9780451524935"; file="1984.jpg"},
    @{isbn="9780553418026"; file="nguoi-ve-tu-sao-hoa.jpg"},
    # Kinh di
    @{isbn="9780385121675"; file="the-shining.jpg"},
    @{isbn="9781501156700"; file="it-stephen-king.jpg"},
    @{isbn="9786041031494"; file="trai-hoa-do.jpg"},
    # Self-help
    @{isbn="9780743269513"; file="7-thoi-quen.jpg"},
    @{isbn="9780449911747"; file="nghi-giau-lam-giau.jpg"},
    @{isbn="9780735211292"; file="atomic-habits.jpg"},
    # Tieu su
    @{isbn="9781451648539"; file="steve-jobs.jpg"},
    @{isbn="9780062301239"; file="elon-musk.jpg"},
    @{isbn="9781400321759"; file="nick-vujicic.jpg"},
    # Truyen ngan
    @{isbn="9786041014459"; file="chi-pheo.jpg"},
    @{isbn="9780385333498"; file="o-henry.jpg"},
    @{isbn="9786041059740"; file="canh-dong-bat-tan.jpg"},
    # Lich su
    @{isbn="9780062316097"; file="luoc-su-loai-nguoi.jpg"},
    @{isbn="9786041220461"; file="viet-nam-su-luoc.jpg"},
    @{isbn="9785050034083"; file="lich-su-the-gioi-co-dai.jpg"},
    # Bai luan
    @{isbn="9780140432077"; file="ban-ve-tu-do.jpg"},
    @{isbn="9780872203433"; file="khao-luan-chinh-phu.jpg"},
    @{isbn="9780807014257"; file="walden.jpg"}
)

foreach ($b in $books) {
    $out = Join-Path $dest $b.file
    if (Test-Path $out) { Write-Host "SKIP: $($b.file)"; continue }
    $url = "https://covers.openlibrary.org/b/isbn/$($b.isbn)-L.jpg"
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -TimeoutSec 15 -ErrorAction Stop
        $size = (Get-Item $out).Length
        if ($size -lt 5000) {
            # Ảnh quá nhỏ = không tìm thấy trên OL, thử by title
            Remove-Item $out -Force
            Write-Host "SMALL(skip): $($b.file) ($size bytes)"
        } else {
            Write-Host "OK: $($b.file) ($size bytes)"
        }
    } catch {
        Write-Host "ERR: $($b.file) - $_"
    }
}
Write-Host "=== Done ==="
