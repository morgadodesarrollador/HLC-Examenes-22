import { BadRequestException, Injectable, InternalServerErrorException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateAparatoDto } from './dto/create-aparato.dto';
import { UpdateAparatoDto } from './dto/update-aparato.dto';
import { Aparato } from './entities/aparato.entity';
import { Repository } from 'typeorm';

@Injectable()
export class AparatosService {

  constructor(
    @InjectRepository(Aparato)
    private readonly aparatosRepository: Repository<Aparato>
  ){}

  async create(createAparatoDto: CreateAparatoDto) {
    try {
      const aparato = this.aparatosRepository.create(createAparatoDto);
      await this.aparatosRepository.save(aparato);
      return (aparato);
    }catch(error) {
      this.handleDBErrors(error)
    }
  }

  findAll() {
    return this.aparatosRepository.find({})
  }

  findOne(cod: string) {
    return this.aparatosRepository.findOne({
      where: {
        cod
      }
    })
  }

  async deleteAllProductos(){
    const query = this.aparatosRepository.createQueryBuilder('aparato');
    try {
      return await query
        .delete()
        .where({})
        .execute()
    }catch(error){
      this.handleDBErrors(error)
    }
  }

  private handleDBErrors (error: any): never{
    
    throw new BadRequestException(error.detail)
  
  }
}

