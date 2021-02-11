/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
import { ArgumentMetadata, BadRequestException, Injectable, PipeTransform } from "@nestjs/common";
import { ObjectSchema } from "joi";

@Injectable()
export class JoiValidationPipe implements PipeTransform {
  constructor(
    private schema: ObjectSchema
  ) {}

  transform(value: any, metadata: ArgumentMetadata): any {
    const { error } = this.schema.validate(value);
    if (error) {
      throw new BadRequestException('Validation Failed');
    }
    return value;
  }
}