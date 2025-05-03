{{/*
定义fullname辅助函数
生成应用的完整名称，通常用于资源命名
此名称将被截断为63个字符
*/}}
{{- define "mysql.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
定义name辅助函数
生成应用的基本名称，可用于生成资源名称
*/}}
{{- define "mysql.name" -}}
mysql
{{- end -}}

{{/*
定义chart辅助函数
生成chart的标准标签名称，格式为"<chart名称>-<chart版本>"
*/}}
{{- define "mysql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
定义labels辅助函数
生成通用标签，用于标识此应用的所有资源
*/}}
{{- define "mysql.labels" -}}
helm.sh/chart: {{ include "mysql.chart" . }}
{{ include "mysql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
定义selectorLabels辅助函数
生成选择器标签，用于Pod选择器
*/}}
{{- define "mysql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mysql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }} 