{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "juiceshop.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "juiceshop.labels" -}}
helm.sh/chart: {{ include "juiceshop.chart" . }}
{{ include "juiceshop.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "juiceshop.selectorLabels" -}}
app.kubernetes.io/name: "{{ .Release.Name }}"
app.kubernetes.io/instance: {{ .Release.Name }}
nosecurity.dev/chart_name: "{{ .Chart.Name}}"
nosecurity.dev/isolation: "insecure-lab"

{{- end }}

