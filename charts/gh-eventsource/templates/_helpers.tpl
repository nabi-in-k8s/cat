{{- define "gh-eventsource.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride  -}}
{{- end -}}

# define chart name
{{- define "gh-eventsource.name" }}
  {{- default "gh-eventsource" .Values.nameOverride }}
{{- end -}}

# define chart fullname (for use in names, labels)
{{- define "gh-eventsource.fullname" }}
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
{{- define "gh-eventsource.chart" }}
{{- printf "%s-%s"  .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

# define selectorLabels
{{- define "gh-eventsource.selectorLabels" }}
app.kubernetes.io/name: {{ include "gh-eventsource.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

# define commonLabels
{{- define "gh-eventsource.labels" -}}
helm.sh/chart: {{ include "gh-eventsource.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- include "gh-eventsource.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{- .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}