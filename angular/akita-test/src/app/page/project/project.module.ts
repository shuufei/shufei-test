import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProjectComponent } from './project.component';
import { ProjectPageRoutingModule } from './project-routing.module';

@NgModule({
  declarations: [ProjectComponent],
  imports: [CommonModule, ProjectPageRoutingModule],
})
export class ProjectModule {}
