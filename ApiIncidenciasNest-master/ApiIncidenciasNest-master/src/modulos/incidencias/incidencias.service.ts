import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateIncidenciaDto } from './dto/create-incidencia.dto';
import { UpdateIncidenciaDto } from './dto/update-incidencia.dto';
import { Incidencia } from './entities/incidencia.entity';
import { Repository } from 'typeorm';
import { Aparato } from '../aparatos/entities/aparato.entity';
import { User } from '../auth/entities/user.entity';
import { AparatosService } from '../aparatos/aparatos.service';
import { AuthService } from '../auth/auth.service';

@Injectable()
export class IncidenciasService {
  constructor(
    @InjectRepository(Incidencia)
    private readonly incidenciasRepository: Repository<Incidencia>,
    private readonly aparatosSerevice: AparatosService,
    private readonly usuariosService: AuthService
  ){}
  async create(createIncidenciaDto: CreateIncidenciaDto) {
    try {
      const { idea, cod, ...data } = createIncidenciaDto;
      const incidencia = this.incidenciasRepository.create({ ...data });
      incidencia.aparato = await this.aparatosSerevice.findOne(cod);
      incidencia.usuario = await this.usuariosService.findOne(idea);
      await this.incidenciasRepository.save(incidencia);
      return incidencia
    }catch (error) {
      this.handleDBErrors(error)
    }
  }

  findAll() {
    return this.incidenciasRepository.find({})
  }

  findOne(id: string) {
    return `This action returns a #${id} incidencia`;
  }

  update(id: number, updateIncidenciaDto: UpdateIncidenciaDto) {
    return `This action updates a #${id} incidencia`;
  }

  remove(id: number) {
    return `This action removes a #${id} incidencia`;
  }

  private handleDBErrors (error: any): never{
    
    throw new BadRequestException(error.detail)
  
  }
}
