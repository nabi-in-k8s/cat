{{/*
Expand the name of the JWT secret.
*/}}
{{- define "supabase.secret.jwt" -}}
{{- printf "%s-jwt-secret" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the SMTP secret.
*/}}
{{- define "supabase.secret.smtp" -}}
{{- printf "%s-smtp-secret" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the dashboard secret.
*/}}
{{- define "supabase.secret.dashboard" -}}
{{- printf "%s-dashboard-secret" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the database secret.
*/}}
{{- define "supabase.secret.db" -}}
{{- printf "%s-db-secret" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the analytics secret.
*/}}
{{- define "supabase.secret.analytics" -}}
{{- printf "%s-analytics-secret" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the s3 secret.
*/}}
{{- define "supabase.secret.s3" -}}
{{- printf "%s-s3-secret" (include "supabase.fullname" .) }}
{{- end -}}
