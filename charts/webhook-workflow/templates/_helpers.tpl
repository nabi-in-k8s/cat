{{- define "webhook-workflow.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride  -}}
{{- end -}}

# define chart name
{{- define "webhook-workflow.name" }}
  {{ default "webhook-workflow" .Values.nameOverride }}
{{- end -}}

# define chart fullname (for use in names, labels)
{{- define "webhook-workflow.fullname" }}
  {{- if .Values.fullnameOverride -}}
    {{- .Values.fullnameOverride | trunc 63 | trimPrefix "-" -}}
  {{- else -}}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
      {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{ else }}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
    {{ end }}
  {{- end -}}
{{- end -}}

# define chart
{{- define "webhook-workflow.chart" }}
  {{- printf "%s-%s"  .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

# define selectorLabels
{{- define "webhook-workflow.selectorLabels" }}
app.kubernetes.io/name: {{ include "webhook-workflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

# define commonLabels
{{- define "webhook-workflow.labels" }}
helm.sh/chart: {{ include "webhook-workflow.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "webhook-workflow.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}