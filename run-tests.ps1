npx jest --coverage --coverageReporters="json-summary" --coverageReporters="lcov" --json --outputFile="jest-results.json" 2>$null | Out-Null

$results = Get-Content "jest-results.json" -Raw | ConvertFrom-Json
$coverage = Get-Content "coverage/coverage-summary.json" -Raw | ConvertFrom-Json

Write-Host "`n=== (a) RESUMEN DE PRUEBAS ===" -ForegroundColor Cyan
Write-Host "Pruebas que pasan : $($results.numPassedTests)" -ForegroundColor Green
Write-Host "Pruebas que fallan: $($results.numFailedTests)" -ForegroundColor Red

Write-Host "`n=== (b) PRUEBAS QUE FALLAN ===" -ForegroundColor Cyan
if ($results.numFailedTests -gt 0) {
    foreach ($suite in ($results.testResults)) {
        foreach ($test in ($suite.assertionResults)) {
            if ($test.status -eq "failed") {
                Write-Host "- $($test.fullName)" -ForegroundColor Red
            }
        }
    }
} else {
    Write-Host "Ninguna prueba fallo." -ForegroundColor Green
}

Write-Host "`n=== (c) PORCENTAJE DE COBERTURA TOTAL ===" -ForegroundColor Cyan
Write-Host "Cobertura de sentencias (Statements): $($coverage.total.statements.pct)%" -ForegroundColor Yellow
Write-Host "Cobertura de lineas (Lines)         : $($coverage.total.lines.pct)%" -ForegroundColor Yellow

Write-Host "`n=== (d) ARCHIVOS DE src/ SIN COBERTURA (0%) ===" -ForegroundColor Cyan
foreach ($prop in ($coverage.PSObject.Properties)) {
    if ($prop.Name -ne "total" -and $prop.Value.lines.pct -eq 0) {
        $relativePath =$prop.Name -replace ".*infra-monitor-kit[\\/]", ""
        Write-Host "- $relativePath" -ForegroundColor Magenta
    }
}
Write-Host ""
Remove-Item "jest-results.json" -ErrorAction SilentlyContinue