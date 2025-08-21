# Flutter Study Repository

## branch별로 작업

## create flutter project for only mobile without linux, macos, windows, web
```shell
flutter create --platforms ios,android [프로젝트 이름]
```

## formatter
- analysis_options.yaml
append this under include..
```yaml
formatter:
  trailing_commas: preserve
  page_width: 80
```