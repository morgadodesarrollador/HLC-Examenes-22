import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './modulos/index';
import { AparatosModule } from './modulos/aparatos/aparatos.module';
import { IncidenciasModule } from './modulos/incidencias/incidencias.module';
import { SeedModule } from './modulos/seed/seed.module';

@Module({
  controllers: [],
  providers: [],
  imports: [
    ConfigModule.forRoot(),
    TypeOrmModule.forRoot({
      type:'postgres',
      host: process.env.DB_HOST,
      port: 5432,
      database: process.env.DB_NAME,
      username: process.env.DB_USERNAME,
      password: process.env.DB_PASSWORD,
      autoLoadEntities: true,
      synchronize:true
    }),
    AuthModule,
    AparatosModule,
    IncidenciasModule,
    SeedModule,
  ]
})
export class AppModule {}
