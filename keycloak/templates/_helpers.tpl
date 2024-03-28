{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "keycloak.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "keycloak.labels" -}}
helm.sh/chart: {{ include "keycloak.chart" . }}
{{ include "keycloak.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "keycloak.selectorLabels" -}}
app.kubernetes.io/name: "{{ .Release.Name }}"
app.kubernetes.io/instance: {{ .Release.Name }}
nosecurity.dev/chart_name: "keycloak"
nosecurity.dev/isolation: "authz"

{{- end }}

