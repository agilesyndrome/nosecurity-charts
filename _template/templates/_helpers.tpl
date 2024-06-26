{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "<CHARTNAME>.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "<CHARTNAME>.labels" -}}
helm.sh/chart: {{ include "<CHARTNAME>.chart" . }}
{{ include "<CHARTNAME>.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "<CHARTNAME>.selectorLabels" -}}
app.kubernetes.io/name: "{{ .Release.Name }}"
app.kubernetes.io/instance: {{ .Release.Name }}
nosecurity.dev/chart_name: "<CHARTNAME>"
nosecurity.dev/isolation: "insecure-lab"

{{- end }}

