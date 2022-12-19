import { Module } from '@nestjs/common';
import { IncidenciasService } from './incidencias.service';
import { IncidenciasController } from './incidencias.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Incidencia } from './entities/incidencia.entity';
import { AuthModule } from '../auth/auth.module';
import { AparatosModule } from '../aparatos/aparatos.module';

@Module({
  controllers: [IncidenciasController],
  providers: [IncidenciasService],
  imports: [
    ConfigModule,
    AuthModule,
    AparatosModule,
    TypeOrmModule.forFeature([Incidencia])
  ],
  exports: [ IncidenciasService ]
})
export class IncidenciasModule {}
