{{/* chart name (CHART_NAME) */}}
{{- define "general.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimPrefix "-" }}
{{- end }}

{{/* chart name with version (CHART_NAME-0.1.0) */}}
{{- define "general.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* app name (SERVICE_NAME) */}}
{{- define "general.fullname" }}
{{/* if value overrides name (fullnameOveride) */}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{/* define $name same as general.name */}}
{{- $name := default .Chart.Name .Values.nameOveride }}
{{/* if $name contains release name (RELEASE_NAME) */}}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{/* else, display (RELEASE_NAME-CHART_NAME) */}}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/* service namespace */}}
{{- define "general.namespace" }}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{/* common labels */}}
{{- define "general.labels" }}
helm.sh/chart: {{ include "general.chart" . }}
{{ include "general.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.labels -}}
{{ .Values.labels }}
{{- end -}}
{{- end }}

{{/* selector labels */}}
{{- define "general.selectorLabels" }}
app.kubernetes.io/name: {{ include "general.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}