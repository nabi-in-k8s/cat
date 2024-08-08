// define teamcity's name
{{- define "teamcity.name" -}}
{{- default .Chart.Name .Values.teamcity.override.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

// define teamcity's fullname
{{- define "teamcity.fullname" -}}
// if override fullname
{{- if .Values.teamcity.override.fullname -}}
{{- .Values.teamcity.override.fullname | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.teamcity.override.name -}}
// if release name contains chart name (or override name)
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
// if not, concat release name and chart name
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

// define teamcity's chart version and name
{{- define "teamcity.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

// define namespace
{{- define "teamcity.namespace" -}}
{{- default .Release.Namespace .Values.teamcity.override.namespace -}}
{{- end -}}

// define server's image tag
{{- define "teamcity.server.imageTag" -}}
{{- default .Values.teamcity.version -}}
{{- end -}}

// define agent's image tag
{{- define "teamcity.agent.imageTag" -}}
{{- $version := .Values.teamcity.version -}}
// arch=arm64 + sudo=true
{{- if and (eq .Values.agent.image.arch "arm64") .Values.agent.image.sudo -}}
{{ printf "%s-linux-arm64-sudo" $version }}
// arch=arm64
{{- else if eq .Values.agent.image.arch "arm64" -}}
{{ printf "%s-linux-arm64" $version }}
// arch=amd64 + sudo=true
{{- else if .Values.agent.image.sudo -}}
{{ printf "%s-linux-sudo" $version }}
// etc
{{- else -}}
$version
{{- end -}}
{{- end -}}