$path = 'C:\Users\Muhammad Sayf\.ilmucode\workspace\default\index.html'
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add('http://127.0.0.1:8765/')
$listener.Start()
while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    try {
        $html = [System.IO.File]::ReadAllBytes($path)
        $ctx.Response.ContentType = 'text/html; charset=utf-8'
        $ctx.Response.ContentLength64 = $html.Length
        $ctx.Response.OutputStream.Write($html, 0, $html.Length)
        $ctx.Response.OutputStream.Close()
    } catch { }
    finally { $ctx.Response.Close() }
}
