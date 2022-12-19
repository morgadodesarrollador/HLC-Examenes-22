import { Module } from '@nestjs/common';
import { AparatosService } from './aparatos.service';
import { AparatosController } from './aparatos.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Aparato } from './entities/aparato.entity';

@Module({
  controllers: [AparatosController],
  providers: [AparatosService],
  imports: [
    ConfigModule,
    TypeOrmModule.forFeature([ Aparato])
  ],
  exports: [ AparatosService ]
})
export class AparatosModule {}
