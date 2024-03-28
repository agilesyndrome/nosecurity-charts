{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cnpg-cluster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cnpg-cluster.labels" -}}
helm.sh/chart: {{ include "cnpg-cluster.chart" . }}
{{ include "cnpg-cluster.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "cnpg-cluster.selectorLabels" -}}
app.kubernetes.io/name: "{{ .Release.Name }}"
app.kubernetes.io/instance: {{ .Release.Name }}
nosecurity.dev/chart_name: "cnpg-cluster"
nosecurity.dev/isolation: "insecure-lab"

{{- end }}

