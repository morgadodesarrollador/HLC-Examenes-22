import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { AparatosService } from './aparatos.service';
import { CreateAparatoDto } from './dto/create-aparato.dto';
import { UpdateAparatoDto } from './dto/update-aparato.dto';

@Controller('aparatos')
export class AparatosController {
  constructor(private readonly aparatosService: AparatosService) {}

  @Post()
  create(@Body() createAparatoDto: CreateAparatoDto) {
    return this.aparatosService.create(createAparatoDto);
  }

  @Get()
  findAll() {
    return this.aparatosService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.aparatosService.findOne(id);
  }

}
