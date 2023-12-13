{{- define "cat-general.name" -}}
  {{ default .Chart.Name .Values.nameOverride }}
{{- end }}

{{- define "cat-general.fullname" -}}
  {{ if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{ else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
      {{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{ else }}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{ end }}
  {{ end }}
{{- end }}

{{- define "cat-general.namespace" -}}
  {{ default .Release.Namespace .Values.namespaceOverride }}
{{- end }}

{{- define "cat-general.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "cat-general.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cat-general.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "cat-general.labels" -}}
helm.sh/chart: {{ include "cat-general.chart" . }}
{{ include "cat-general.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

