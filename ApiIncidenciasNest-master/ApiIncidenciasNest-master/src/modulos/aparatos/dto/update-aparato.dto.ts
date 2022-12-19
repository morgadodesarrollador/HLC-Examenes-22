import { PartialType } from '@nestjs/mapped-types';
import { CreateAparatoDto } from './create-aparato.dto';

export class UpdateAparatoDto extends PartialType(CreateAparatoDto) {}
