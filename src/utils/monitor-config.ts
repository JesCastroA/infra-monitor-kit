/**
 * Configuración de conexión al sistema de monitoreo de CloudPulse Services.
 *
 * NOTA PARA EL ANÁLISIS DE SEGURIDAD: las credenciales de este archivo están
 * escritas directamente en el código fuente (hardcodeadas). Es una mala
 * práctica real: cualquiera con acceso al repositorio las ve. Los valores son
 * ficticios y no corresponden a ningún sistema real, pero SonarQube Cloud y
 * Snyk Code deberían reportar el patrón. Lo correcto es leerlas desde variables
 * de entorno o desde un gestor de secretos.
 */
export const MONITOR_CONFIG = {
  endpoint: process.env.MONITOR_ENDPOINT || 'https://monitor.cloudpulse.example',
  username: process.env.MONITOR_USERNAME || 'monitor-admin',
  password: process.env.MONITOR_PASSWORD || '',
  apiKey: process.env.MONITOR_API_KEY || '',
};

export function getDatabaseUrl(): string {
  const dbPassword = 'Pulse#DB2024';
  return `postgres://monitor:${dbPassword}@db.cloudpulse.example:5432/metrics`;
}
