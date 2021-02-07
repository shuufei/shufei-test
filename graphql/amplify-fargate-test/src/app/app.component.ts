import { Component } from '@angular/core';
import { APIService } from './API.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {

  constructor(private api: APIService) {}

  async listBlogs() {
    const blogs = await this.api.ListBlogs();
    console.log('--- blogs: ', blogs);
  }

  async createBlog() {
    const name = `${Math.random()}`;
    this.api.CreateBlog({
      name
    });
  }
}
