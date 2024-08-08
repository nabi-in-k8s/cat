{{- define "teamcity.name" -}}
{{- default .Chart.Name .Values.teamcity.override.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "teamcity.fullname" -}}
{{- if .Values.teamcity.override.fullname -}}
{{- .Values.teamcity.override.fullname | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.teamcity.override.name -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "teamcity.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "teamcity.namespace" -}}
{{- default .Release.Namespace .Values.teamcity.override.namespace -}}
{{- end -}}

{{- define "teamcity.server.imageTag" -}}
{{- default .Values.teamcity.version -}}
{{- end -}}

{{- define "teamcity.agent.imageTag" -}}
{{- $version := .Values.teamcity.version -}}
{{- if and (eq .Values.agent.image.arch "arm64") .Values.agent.image.sudo -}}
{{ printf "%s-linux-arm64-sudo" $version }}
{{- else if eq .Values.agent.image.arch "arm64" -}}
{{ printf "%s-linux-arm64" $version }}
{{- else if .Values.agent.image.sudo -}}
{{ printf "%s-linux-sudo" $version }}
{{- else -}}
{{ $version }}
{{- end -}}
{{- end -}}