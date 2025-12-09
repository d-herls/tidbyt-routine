# --- Settings ---
$device = "mockingly-whole-prepared-chinook-181"
$token  = "eyJhbGciOiJFUzI1NiIsImtpZCI6IjY1YzFhMmUzNzJjZjljMTQ1MTQyNzk5ODZhMzYyNmQ1Y2QzNTI0N2IiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJodHRwczovL2FwaS50aWRieXQuY29tIiwiZXhwIjozMzQyMDU0MTkzLCJpYXQiOjE3NjUyNTQxOTMsImlzcyI6Imh0dHBzOi8vYXBpLnRpZGJ5dC5jb20iLCJzdWIiOiJ1TzBDYlVwQkNFZ2lCaFIwbGpZZGJabE5CY0QzIiwic2NvcGUiOiJkZXZpY2UiLCJkZXZpY2UiOiJtb2NraW5nbHktd2hvbGUtcHJlcGFyZWQtY2hpbm9vay0xODEifQ.anvYXYWMjn-aO3Ptp-6Taoo8015j1nDb5iOj_qzIzkc3qqvGDw48Dq49vNYKmEG5_BlvUuSJyVmkEo_Omtp-UA"   # replace with yours (keep private)
$applet = "routine.star"
$output = "routine.webp"

# --- Render the applet ---
pixlet render $applet -o $output

# --- Push the rendered image to Tidbyt ---
pixlet push `
  --api-token $token `
  --installation-id routine `
  $device `
  $output
