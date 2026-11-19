$root = "C:\Users\Muhammad Sayf\.ilmucode\workspace\default"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8741/")
$listener.Start()
Write-Output "serving on http://localhost:8741"
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $rel = $ctx.Request.Url.AbsolutePath.TrimStart("/")
  if ($rel -eq "" -or $rel -eq "/") { $rel = "index.html" }
  $file = Join-Path $root ($rel -replace "/", "\")
  if (Test-Path $file -PathType Leaf) {
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $ctx.Response.ContentType = "text/html; charset=utf-8"
    $ctx.Response.ContentLength64 = $bytes.Length
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else {
    $ctx.Response.StatusCode = 404
  }
  $ctx.Response.OutputStream.Close()
}
