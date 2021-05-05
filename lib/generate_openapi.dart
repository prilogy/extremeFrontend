import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
        AdditionalProperties(pubName: 'api', pubAuthor: 'Artyom Lukyanov'),
    inputSpecFile: 'spec/openapi.yaml',
    generatorName: Generator.dart,
    outputDirectory: 'api')
class GenerateOpenAPI extends OpenapiGeneratorConfig {}
