{{/*
Create our tags 
*/}}
{{- define "app.labels" -}}
app: {{ .name | quote }}
env: {{ .labels.env | quote }}
live: {{ .labels.live | quote }}
{{- end }}

{{/*
Create a deployment
*/}}
{{- define "app.deployment" -}}
spec:
    replicas: {{ .replicas }}
    selector:
        matchLabels:
            app: {{ .name | quote }}
    template:
        metadata:
            labels: {{- include "app.labels" . | nindent 16 }}
        spec:
            containers:
                - name: {{ .name }}
                  image: {{ .image }}
                  ports:
                    {{- range $port := .ports }}
                    - containerPort: {{ $port.containerPort }}
                    {{- end }}
                  imagePullPolicy: Always
                  resources:
                      {{- range $component, $config := .resources }}
                      {{ $component }}:
                        memory: {{ $config.memory }}
                        cpu: {{ $config.cpu }}
                      {{- end }}
{{- end }}

{{/*
Create a config map
*/}}
{{- define "app.configMap" }}
apiVersion: v1
kind: ConfigMap
metadata:
    name: {{ .name }}
data:
    {{- range $component, $config := .data }}
    {{ $component }}: |+
        {{- toYaml $config | nindent 6 }}
    {{- end }}
{{- end }}
