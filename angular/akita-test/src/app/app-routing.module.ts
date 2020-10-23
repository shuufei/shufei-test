import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  {
    path: 'project',
    loadChildren: () =>
      import('./page/project/project.module').then((m) => m.ProjectModule),
  },
  {
    path: 'schedule',
    loadChildren: () =>
      import('./page/schedule/schedule.module').then((m) => m.ScheduleModule),
  },
  // {
  //   path: 'mypage',
  //   loadChildren: () =>
  //     import('@view/page/my-tasks-page/my-tasks-page.module').then(
  //       (m) => m.MyTasksPageModule
  //     ),
  // },
  {
    path: '**',
    redirectTo: '/project',
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
