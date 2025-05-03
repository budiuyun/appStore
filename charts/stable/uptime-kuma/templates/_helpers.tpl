{{/* 
Generate the full name of the release, limiting to 63 characters 
*/}}
{{- define "uptime-kuma.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* 
Generate the name of the chart 
*/}}
{{- define "uptime-kuma.name" -}}
uptime-kuma
{{- end -}}

{{/* 
Generate common labels 
*/}}
{{- define "uptime-kuma.labels" -}}
app.kubernetes.io/name: {{ include "uptime-kuma.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "uptime-kuma.selectorLabels" -}}
app.kubernetes.io/name: {{ include "uptime-kuma.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}